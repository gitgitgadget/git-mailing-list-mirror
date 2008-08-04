From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Mon, 04 Aug 2008 13:30:05 +0200
Organization: lilypond-design.org
Message-ID: <1217849405.7649.27.camel@heerbeest>
References: <1217684549.8296.10.camel@heerbeest>
	 <20080802172742.GT32184@machine.or.cz>
	 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
	 <1217701021.8296.35.camel@heerbeest> <20080804020931.GA4109@untitled>
	 <1217836189.7649.7.camel@heerbeest>  <20080804090309.GD5435@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 13:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPyHP-00075A-W2
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 13:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYHDLaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 07:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbYHDLaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 07:30:09 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:37151 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYHDLaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 07:30:08 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 8EBAC6775A;
	Mon,  4 Aug 2008 13:30:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id EF885DC168;
	Mon,  4 Aug 2008 13:30:05 +0200 (CEST)
In-Reply-To: <20080804090309.GD5435@hand.yhbt.net>
X-Mailer: Evolution 2.23.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91342>

On ma, 2008-08-04 at 02:03 -0700, Eric Wong wrote:

> In the one-shot case, a git filter-branch script would probably be ideal
> and reusable for other projects.

That's a nice idea!

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
