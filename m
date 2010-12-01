From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 1 Dec 2010 13:58:43 -0800
Message-ID: <295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net> <20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net> <7vzkspuw8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNuhR-0001gq-N1
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab0LAV6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 16:58:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33874 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab0LAV6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 16:58:48 -0500
Received: by pwj3 with SMTP id 3so1201296pwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 13:58:47 -0800 (PST)
Received: by 10.142.44.7 with SMTP id r7mr9762305wfr.114.1291240727784;
        Wed, 01 Dec 2010 13:58:47 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm522728wfd.22.2010.12.01.13.58.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 13:58:46 -0800 (PST)
In-Reply-To: <7vzkspuw8g.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162618>

On Dec 1, 2010, at 11:30 AM, Junio C Hamano wrote:

>> You read from top to bottom, therefore
>> A-Z.
> 
> I used to think that back when I referred to printed documentation more
> often than online, but not anymore.  Alphabetical ordering is somewhat
> last century; the documentation is often more useful if the options are
> grouped together by features and concepts they relate to.

I completely agree. Alphabetical sorting is only useful when you already
know the name of the command you want, and you have no search function.
If you don't know the name of the command you want, then grouping by
functionality is far better, and if you have a search function, then there
is no real benefit at all to A-Z sorting. Trying to make the manpage look
"nice" at the expense of removing functional grouping is misguided.

-Kevin Ballard
