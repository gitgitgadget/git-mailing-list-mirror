From: Nicolas Pitre <nico@cam.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 13:55:32 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:56:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqu42-0006Ue-K4
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYD2Rzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYD2Rzh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:55:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19007 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYD2Rzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:55:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K030063VLSK7VD1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Apr 2008 13:55:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80711>

On Tue, 29 Apr 2008, Geoffrey Irving wrote:

> Sorry for the confusion: it would handwaving if I was saying git was insecure,
> but I'm not.  I'm saying that if or when SHA1 becomes vulnerable to collision
> attacks, git will be insecure.

Right.  And if or when that happens then we'll make Git secure again 
with a different hash.  In the mean time there is low return for the 
effort involved.


Nicolas
