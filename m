From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] bash-completion: add --edit-description to choices for
 branch
Date: Mon, 6 Feb 2012 19:16:08 -0500
Message-ID: <4F306D48.1060103@windriver.com>
References: <1328547807-3374-1-git-send-email-paul.gortmaker@windriver.com> <871uq7sfwb.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 07 01:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuYjO-0001BE-98
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 01:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab2BGAQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 19:16:17 -0500
Received: from mail1.windriver.com ([147.11.146.13]:64983 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab2BGAQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 19:16:17 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q170GAZq007682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 6 Feb 2012 16:16:10 -0800 (PST)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Mon, 6 Feb 2012
 16:16:09 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111109 Thunderbird/3.1.16
In-Reply-To: <871uq7sfwb.fsf@thomas.inf.ethz.ch>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190124>

On 12-02-06 06:25 PM, Thomas Rast wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> Support was recently added to allow storing a branch description,
>> so teach bash completion about it.
> 
> See 48c07d8 (completion: --edit-description option for git-branch,
> 2012-01-29) which is already in next.

OK thanks,  I did a quick google, didn't get any obvious
clues that it was done already, but must have missed it.

P.

> 
