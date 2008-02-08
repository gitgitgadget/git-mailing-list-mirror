From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Make use of the $git_dir variable at sub
	git_get_project_url_list
Date: Fri, 8 Feb 2008 02:15:42 -0200
Message-ID: <20080208041542.GA28336@c3sl.ufpr.br>
References: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br> <m3ve51511t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNKfi-0000bc-8j
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbYBHEQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933927AbYBHEQO
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:16:14 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:40719 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbYBHEQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:16:06 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 412D0700003CF;
	Fri,  8 Feb 2008 02:16:05 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m3ve51511t.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73032>

Just Remembering

On Wed, Feb 06, 2008 at 11:37:51AM -0800, Jakub Narebski wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
><snip> 
> Good catch (although it wasn't actually a bug).

Not a bug but makes the code cleaner =)
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
