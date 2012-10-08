// **********************************************************************
//
// Copyright (c) 2003-2012 ZeroC, Inc. All rights reserved.
//
// This copy of Ice is licensed to you under the terms described in the
// ICE_LICENSE file included in this distribution.
//
// **********************************************************************

package IceMX;

public class InvocationObserverI extends Observer<InvocationMetrics> implements Ice.Instrumentation.InvocationObserver
{
    static private final class RemoteInvocationHelper extends MetricsHelper<Metrics>
    {
        static private final AttributeResolver _attributes = new AttributeResolver()
            { 
                {
                    try
                    {
                        Class<?> cl = RemoteInvocationHelper.class;
                        add("parent", cl.getDeclaredMethod("getParent"));
                        add("id", cl.getDeclaredMethod("getId"));
                        add("endpoint", cl.getDeclaredMethod("getEndpoint"));
                        CommunicatorObserverI.addConnectionAttributes(this, RemoteInvocationHelper.class);
                    }
                    catch(Exception ex)
                    {
                        ex.printStackTrace();
                        assert(false);
                    }
                }
            };

        RemoteInvocationHelper(Ice.ConnectionInfo con, Ice.Endpoint endpt) 
        {
            super(_attributes);
            _connectionInfo = con;
            _endpoint = endpt;
        }

        String
        getId()
        {
            if(_id == null)
            {
                _id = _endpoint.toString();
                if(_connectionInfo.connectionId != null && !_connectionInfo.connectionId.isEmpty())
                {
                    _id += " [" + _connectionInfo.connectionId + "]";
                }
            }
            return _id;
        }
    
        String 
        getParent()
        {
            if(_connectionInfo.adapterName != null && !_connectionInfo.adapterName.isEmpty())
            {
                return _connectionInfo.adapterName;
            }
            else
            {
                return "Communicator";
            }
        }
        
        Ice.ConnectionInfo
        getConnectionInfo()
        {
            return _connectionInfo;
        }
        
        Ice.Endpoint
        getEndpoint()
        {
            return _endpoint;
        }

        Ice.EndpointInfo
        getEndpointInfo()
        {
            if(_endpointInfo == null)
            {
                _endpointInfo = _endpoint.getInfo();
            }
            return _endpointInfo;
        }

        String
        getEndpointEncodingVersion()
        {
            return Ice.Util.encodingVersionToString(getEndpointInfo().encoding);
        }
    
        String
        getEndpointProtocolVersion()
        {
            return Ice.Util.protocolVersionToString(getEndpointInfo().protocol);
        }

        final private Ice.ConnectionInfo _connectionInfo;
        final private Ice.Endpoint _endpoint;
        private String _id;
        private Ice.EndpointInfo _endpointInfo;
    };

    public void
    retried()
    {
        forEach(_incrementRetry);
    }
    
    public Observer 
    getRemoteObserver(Ice.ConnectionInfo con, Ice.Endpoint endpt)
    {
        return getObserver("Remote", new RemoteInvocationHelper(con, endpt), Metrics.class, ObserverI.class);
    }

    final MetricsUpdate<InvocationMetrics> _incrementRetry = new MetricsUpdate<InvocationMetrics>()
        {
            public void
            update(InvocationMetrics v)
            {
                ++v.retry;
            }
        };
}