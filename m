From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Wed, 16 Dec 2015 07:58:30 +0100
Message-ID: <56710B96.30103@web.de>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 07:58:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9636-0003uL-JA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 07:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933934AbbLPG6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 01:58:44 -0500
Received: from mout.web.de ([212.227.17.11]:49247 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933854AbbLPG6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 01:58:38 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M0QYD-1aTv9G2wjF-00udyE; Wed, 16 Dec 2015 07:58:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:VwSyQ7Gf8uNao/4PZbQWym5k9x97TwWYgJ8CbYJtiE1oNstTyFm
 OU/KIy6Xl5UumnlrVlt42PeGJO191/k1FMckKUU2/ZQPIjZb6VGXFhk+i7fG0emEExXvCI1
 baIsCYZS6m1sLd34StqXTuSeE4hUD+jsuGeVhv80MV03MjNevpqT6lRFN7GQBPhdte0AWMX
 mPFlQ0cDXcCg5pDSArDPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OrlTN9Pqwok=:WuRJMD0/98pVVrROnZKqX8
 B5nxGHSFWKUC7MFQSR2yCpClwn+6ckqwE3SAUXqCANtvGg3A1mNsAsscY6wBN315W0cYoDOa+
 YRHWubOkfOYjUWeh2+h6ezJxragYC62sWvNhY6hSeOCKX6U5Tejykc7tDlvpy2Qm5uAYWf4xb
 XiO4lRnaB5NMSnc8/UmkV43TMkSYksD79KUsaepvVxGqwWa/diHw74Aht8uUyLm11VcjzObuj
 bYfXa2KpgQljdzdawDhYZzK+ZzcrlvB/+DHUVYYmysrTO3KeYj86LIAVxC5BkdEOeG6RILtti
 xTCRigNK+Ik+OVcE9wlZk4KQ7f54SGCZrKHr5zPMArFDt9Bw+OdUhqT8F0IBIz6fFlfmBEJoy
 POu4w1iTDb8bBxBt8hFARINKeceIuNNmuDmR8Y/2RJBmaJn4vTlY/k5rWNtzZf4ll4PH43zKj
 qUWIl+KKhR/tOSE36MhYr0uG6icOas3giLuXoO9UUv9CE8bxoBNHCFu2jVNwqD1mzPxfO+UeY
 fJwI4DHlplhkqkmfOgrhqs/5umhJE4nyyYUl/bkto5saF33YeJvR+D1m5IVS29bbARtULAM+S
 GBp2qS+S4381JizIzNgmwW9TwJ8/5oBN2EL8g2l8H86/ywUXBFwQospxRxMzNJLjwFvlY9ZGd
 XKRRTGfdEMV+HfmpMsjDWNhR3zm2vXQyob5AtKMnKJ5ROU4Ji9oDci9wLsiWHc6TAHhDlS4w3
 NIN40lIBr60d3EbbnKt9E3U8tj4GDKE7DZyZd3nyJJJW/D2X58JxFxAEloJeB4kgTRV8/Ni2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282537>

On 15.12.15 23:48, Junio C Hamano wrote:
> * tb/ls-files-eol (2015-11-28) 2 commits
>  - convert.c: mark a file-local function static
>  - ls-files: Add eol diagnostics
> 
>  Add options to ls-files to help diagnose end-of-line problems.
> 
>  This latest round hasn't gotten any review yet.
> 
>  Waiting for review.

The latest review are here: $gmane/281785 $gmane/282061
And a re-roll is planned the next weeks, sorry for delay.
