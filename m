From: Yann Dirson <dirson@bertin.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 09:48:06 +0100
Organization: Bertin Technologies
Message-ID: <20101206094806.10ae1ff2@chalon.bertin.fr>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
 <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
 <20101206092122.21c19011@chalon.bertin.fr>
 <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWtx-0000Xe-Is
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0LFI6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 03:58:25 -0500
Received: from blois.bertin.fr ([195.68.26.9]:62073 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab0LFI6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 03:58:24 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 3379B543BE
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 09:58:23 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 11C3A543B4
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 09:58:23 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LD000HQ50XAFW10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 06 Dec 2010 09:58:23 +0100 (CET)
In-reply-to: <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17810.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162987>

On Mon, 06 Dec 2010 17:39:54 +0900
Miles Bader <miles@gnu.org> wrote:

> On Mon, Dec 6, 2010 at 5:21 PM, Yann Dirson <dirson@bertin.fr> wrote:
> > Seen that argument before.
> > 1. does anyone care ? (I personally don't)
> 
> If nobody cared, you wouldn't get an argument.

OK, I can hear that - but well, noone complained till now that
--find-copies-harder would sound like "an action to be performed
_instead_ of some normal processing".


But most importantly, I don't get much feedback on the direct
implication of that choice: are we going to have 2 exact synonyms
(--find-copies-harder and --detect-copies-harder) forever, and to what
extent (see prev. mail about completion) ?

In the end, I still think the implications for the usability are what
matters, more than arguing about a subtle nuance of vocabulary.

-- 
Yann Dirson - Bertin Technologies
