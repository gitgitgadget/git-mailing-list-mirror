From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 2 Dec 2007 14:40:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021427280.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 15:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyq0H-0006rw-Nv
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 15:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXLBOkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 09:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbXLBOkl
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 09:40:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:38037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752822AbXLBOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 09:40:41 -0500
Received: (qmail invoked by alias); 02 Dec 2007 14:40:39 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp007) with SMTP; 02 Dec 2007 15:40:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xVHMZMk4xBGJFHqHF1/fjhU2RAqk/sktJcZ78M+
	Lud8vesIXdojlz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66782>

Hi,

On Fri, 30 Nov 2007, Junio C Hamano wrote:

> * js/dashless (Fri Nov 30 12:08:20 2007 +0000) 1 commit
>  - transport.c: call dash-less form of receive-pack and upload-pack
>    on remote
> 
> Not field tested by anybody nor came with any tests, but this is an
> important component to move git-foo commands out of user's PATH.

Please scratch that.  It does not work, and what it should fix is better 
done by your 3/3.

Ciao,
Dscho
