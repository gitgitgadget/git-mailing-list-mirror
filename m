From: chris@seberino.org
Subject: Re: How make "git checkout <commit> <file>" *not* alter index?
Date: Tue, 6 Jan 2009 22:55:38 -0800
Message-ID: <20090107065538.GA10617@seberino.org>
References: <20090106051852.GA3278@seberino.org> <7vk599ne6a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKSMA-0007ES-G7
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbZAGGzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 01:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbZAGGzj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:55:39 -0500
Received: from li30-51.members.linode.com ([65.49.60.51]:43486 "EHLO
	seberino.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbZAGGzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 01:55:38 -0500
Received: by seberino.org (Postfix, from userid 1000)
	id 41AA0184B6; Tue,  6 Jan 2009 22:55:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk599ne6a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104765>

On Mon, Jan 05, 2009 at 10:26:05PM -0800, Junio C Hamano wrote:
>     $ git checkout HEAD~43 Makefile
>     $ git reset Makefile

Thank you very much.  git reset looks that just what I need.

cs
