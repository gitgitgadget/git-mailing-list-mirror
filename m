From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: support 'git notes' and its subcommands
Date: Wed, 27 Jan 2010 17:21:02 -0800
Message-ID: <20100128012102.GL5452@spearce.org>
References: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: SZEDER G??bor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaJ4L-0000Q7-G5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 02:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809Ab0A1BVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 20:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755807Ab0A1BVH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 20:21:07 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:58342 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab0A1BVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 20:21:05 -0500
Received: by iwn16 with SMTP id 16so209602iwn.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 17:21:04 -0800 (PST)
Received: by 10.231.146.79 with SMTP id g15mr543341ibv.49.1264641664784;
        Wed, 27 Jan 2010 17:21:04 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm366594iwn.6.2010.01.27.17.21.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 17:21:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138216>

SZEDER G??bor <szeder@ira.uka.de> wrote:
> ... and it will offer refs unless after -m or -F, because these two
> options require a non-ref argument.
> 
> Signed-off-by: SZEDER G??bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.
