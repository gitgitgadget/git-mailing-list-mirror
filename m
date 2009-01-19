From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v2 1/1] bug fix, diff whitespace ignore options
Date: Mon, 19 Jan 2009 19:36:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191936170.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de> 
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>  <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de> <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com> <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0901190446480.3586@pacific.mpi-cbg.de> <alpine.GSO.2.00.0901191000520.25883@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOz0t-0006L0-69
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZASSgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZASSgo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:36:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752185AbZASSgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:36:43 -0500
Received: (qmail invoked by alias); 19 Jan 2009 18:36:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 19 Jan 2009 19:36:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7e903DV77G4quVzjRO+iIpY+JmnrlKa9IdiWkZX
	L2a7hVaM3iaS6T
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0901191000520.25883@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106379>

Hi,

On Mon, 19 Jan 2009, Keith Cascio wrote:

>  Fixed bug in diff whitespace ignore options.  It is now
>  OK to specify more than one whitespace ignore option
>  on the command line.
> 
> Signed-off-by: Keith Cascio <keith@cs.ucla.edu>

ACK,
Dscho
