From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 07 Dec 2007 16:24:17 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712071622150.555@xanadu.home>
References: <1197061832-8489-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0khM-0006Gj-Pi
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbXLGVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbXLGVYT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:24:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350AbXLGVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:24:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP0049S7GHGMB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 16:24:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1197061832-8489-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67459>

On Fri, 7 Dec 2007, Mike Hommey wrote:

> While most of the time the heuristics used by pack-objects to sort the
> given object list are satisfying enough, there are cases where it can be
> useful for the user to sort the list with heuristics that would be better
> suited.

Could you please elaborate on those cases where the current heuristic 
would be unsatisfactory?


Nicolas
