From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] t7800: don't hide grep output
Date: Fri, 22 Mar 2013 23:32:08 +0100
Message-ID: <514CDBE8.80609@kdbg.org>
References: <20130322115352.GI2283@serenity.lan> <cover.1363980749.git.john@keeping.me.uk> <4cbe25e4b1fd7a8d45067106d24f7d83ca5c8e5b.1363980749.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAVq-00073k-WF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423503Ab3CVWcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:32:10 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:30402 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422648Ab3CVWcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:32:09 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9013AA7EB7;
	Fri, 22 Mar 2013 23:32:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0EFB819F542;
	Fri, 22 Mar 2013 23:32:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <4cbe25e4b1fd7a8d45067106d24f7d83ca5c8e5b.1363980749.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218859>

Am 22.03.2013 20:36, schrieb John Keeping:
> Remove the stdin_contains and stdin_doesnt_contain helper functions
> which add nothing but hide the output of grep, hurting debugging.

Thanks. Patch looks good.

-- Hannes
