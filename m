From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Smart HTTP
Date: Mon, 13 Oct 2014 22:58:22 +0400
Message-ID: <20141013225822.47d4deb70751eeb4915f69d6@domain007.com>
References: <em4fcc6297-a9c0-4bcf-b7da-6afb6cbe5f80@mesh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Norris" <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdkpL-0001oI-As
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 20:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbaJMS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 14:58:31 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60944 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbaJMS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 14:58:30 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s9DIwM5H014569;
	Mon, 13 Oct 2014 22:58:23 +0400
In-Reply-To: <em4fcc6297-a9c0-4bcf-b7da-6afb6cbe5f80@mesh>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Oct 2014 17:29:05 +0000
"John Norris" <john@norricorp.f9.co.uk> wrote:

> I guess this comment is aimed at Scott Chacon.
> I have read your blog post on Smart HTTP 
> (http://git-scm.com/blog/2010/03/04/smart-http.html) and wondered if 
> there is any documentation that compares in terms of thoroughness
> with your sections in the book on using SSH, which does explain the
> basics so that "anyone" can get it working.
> I have tried setting up authenticated pull and push with HTTP (not 
> HTTPS) and Apache never asks for authentication during a pull and 
> refuses a push with a 403 error.

Looks like a sort-of followup to this discussion [1].

(John, being a good netizen, you should have included the link to that
discussion yourself, to put your uh comment in context and may be
actually get some useful responses.)

1. https://groups.google.com/d/topic/git-users/zcXYY1Le_F4/discussion
