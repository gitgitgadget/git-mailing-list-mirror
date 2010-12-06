From: Yann Dirson <dirson@bertin.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 09:21:22 +0100
Organization: Bertin Technologies
Message-ID: <20101206092122.21c19011@chalon.bertin.fr>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
 <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:31:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWU8-0007XU-VM
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab0LFIbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 03:31:42 -0500
Received: from blois.bertin.fr ([195.68.26.9]:59974 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab0LFIbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 03:31:42 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B9946543C1
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 09:31:38 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 95BFB543B4
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 09:31:38 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LCZ00HAFZOQFW10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 06 Dec 2010 09:31:38 +0100 (CET)
In-reply-to: <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17810.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162983>

On Mon, 06 Dec 2010 17:13:46 +0900
Miles Bader <miles@gnu.org> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> > But then, why not simply use --find-renames (since --detect-renames
> > has luckily not been released ontl the masses yet), and avoid
> > making similar-usage opts dissimilar and then adding a synonym just
> > to make them similar the other way ?
> 
> "Find" and "detect" have different nuances.
> 
> "Detect" sounds somewhat passive/minor, so "detect renames" makes it
> more clear that renames are detected _in addition_ to normal
> processing.

Seen that argument before.
1. does anyone care ? (I personally don't)
2. whether we care or not we have IMHO to face the implications, see my
other mails about implications of both paths

-- 
Yann Dirson - Bertin Technologies
