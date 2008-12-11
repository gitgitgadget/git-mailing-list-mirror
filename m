From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 20:08:25 -0800 (PST)
Message-ID: <506479.53667.qm@web31812.mail.mud.yahoo.com>
References: <200812110133.33124.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 05:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAcrx-0000B4-3A
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 05:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYLKEI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYLKEI1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:08:27 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:36017 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752814AbYLKEI1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 23:08:27 -0500
Received: (qmail 54178 invoked by uid 60001); 11 Dec 2008 04:08:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=V1oCshYONwoj/TNRG7aNpz/yr254sq+le34aYp+NU+SBzUjyiZM9G8NZQVYKImKi/wxJt4v7bUUzXMR1H6gNYFjNLadrsaQ1KCyGZb2zvjGwMN7rBe9+XrPG7YuRlYaxfi8IeYS8IJuVIFQaFr6okED4W8A4teC/hEG1FD02opA=  ;
Received: from [71.132.216.53] by web31812.mail.mud.yahoo.com via HTTP; Wed, 10 Dec 2008 20:08:25 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <200812110133.33124.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102773>


--- On Wed, 12/10/08, Jakub Narebski <jnareb@gmail.com> wrote:
> Acked-by: Luben Tuikov <ltuikov@yahoo.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I've always seen "Acked-by:" follows "Signed-off-by:".  Junio, has this
changed?

   Luben
