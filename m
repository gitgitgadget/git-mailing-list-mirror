From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT 1.6.0-rc1
Date: Mon, 28 Jul 2008 23:37:27 +0200
Message-ID: <20080728213727.GA3721@blimp.local>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org> <20080728063838.GB4234@blimp.local> <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiQP-0007v7-C7
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbYG2GKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYG2GKH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:10:07 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:40542 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYG2GKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:10:05 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf50O7
Received: from tigra.home (Fae3d.f.strato-dslnet.de [195.4.174.61])
	by post.webmailer.de (klopstock mo59) (RZmta 16.47)
	with ESMTP id g03811k6T3R2IM ; Tue, 29 Jul 2008 08:10:03 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 96201277BD;
	Tue, 29 Jul 2008 08:10:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D0FEC36D1A; Mon, 28 Jul 2008 23:37:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90587>

Junio C Hamano, Mon, Jul 28, 2008 08:44:52 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > t2103-update-index-ignore-missing.sh still broken on Windows because
> > of stat.st_size being 0 for directories there.
> 
> I recall we did not reach a useful conclusion of that discussion.

Why isn't the proposed patch useful? (and would it be possible to make
the answer out of plain, small and short words?)
