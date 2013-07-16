From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] git-log.txt: fix typesetting of example "git-log -L" invocation
Date: Tue, 16 Jul 2013 11:23:02 +0200
Message-ID: <87sizekgeh.fsf@linux-k42r.v.cablecom.net>
References: <1373933436-28599-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:23:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1TR-0004Mw-5V
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab3GPJXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:23:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27504 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab3GPJXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:23:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:22:57 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 16 Jul 2013 11:23:01 +0200
In-Reply-To: <1373933436-28599-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 15 Jul 2013 20:10:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230553>

Eric Sunshine <sunshine@sunshineco.com> writes:

> All surrounding examples are typeset as monospaced text. Follow suit.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-log.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 2ea79ba..2ee6962 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -153,7 +153,7 @@ Examples
>  	This makes sense only when following a strict policy of merging all
>  	topic branches when staying on a single integration branch.
>  
> -git log -L '/int main/',/^}/:main.c::
> +`git log -L '/int main/',/^}/:main.c`::
>  
>  	Shows how the function `main()` in the file 'main.c' evolved
>  	over time.

Ack.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
