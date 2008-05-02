From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation
Date: Fri, 2 May 2008 20:33:01 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805022033.01407.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <18458.65466.449698.790306@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri May 02 21:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0px-0000A7-0j
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764051AbYEBTVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764028AbYEBTVl
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:21:41 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:53207 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762956AbYEBTVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:21:40 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42JLb1N013292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 2 May 2008 21:21:38 +0200
Received: from [192.168.2.102] (p5490016D.dip0.t-ipconnect.de [84.144.1.109])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m42JLaSE006626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 May 2008 21:21:37 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <18458.65466.449698.790306@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81030>

Am Freitag, 2. Mai 2008 13:49 schrieb Paul Mackerras:
> > By the way, the following two keybinding explanations seem ambiguous to 
me:
> > >   <Home>  Move to first commit
> > >   <End>   Move to last commit
> >
> > What happens is that <home> jumps to the newest commit and <end> jumps to
> > the oldest commit. Whether the "first" commit should be the newest or the
> > oldest is, well, somewhat ambiguous. I'd propose to talk about the newest
> > or topmost commit, but rather not about the "first".
>
> Well, the commits aren't in date order, strictly speaking, and the
> last commit isn't necessarily the oldest (though the first commit will
> in fact be the newest).  How about:
>
> <Home>	Move to head of list
> <End>	Move to tail of list
>
> Would that be any clearer?

I think "head of list" and "tail of list" are more the terms about the 
implementation detail and not so much an explanation that is easily 
understood for the user. I think some combination using the word "top" should 
rather be used to make it really clear we're talking about the upper end of 
the window.

Christian
