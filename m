From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 0/10] create ref-filter from for-each-ref
Date: Sat, 06 Jun 2015 16:56:22 +0530
Message-ID: <5572D8DE.7090007@gmail.com>
References: <55729B78.1070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CFI-0002en-GD
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbFFL02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:26:28 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33736 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbFFL00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:26:26 -0400
Received: by padev16 with SMTP id ev16so8103751pad.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=39EMxwJYmI7LcIgg0N3S5RC3n9bu78p/VmarCCz6W1w=;
        b=lXfh9OOGN7LW98I6kYI6LpRFrUP7kYwBGJqQOKdba+/9pwEwQF3+gbWSbQ0JPQWade
         ABDXcEyW+fCzcqgqbeIadHXB6IdrYBLYH2mS2yUPbdlYQB9IrfK0Exd6y/8Oy11IyKuc
         e/cPgbePIbcXfPtHDHAq6pslFeLn/BNId7T/Kevz55Il8rM3UjYMe5L7trB5mfGVMGiy
         ysKC7eCEScrfK5mm010kb4rWEnfCH6ELgNtgu1ia5hJX4CNQ2eGZUTO9elEMJeNLGhC7
         JBbBwpApofrnTr4jG4BUrwu/5AfDpyqZTcYvlMflQ4u+f215fUtEX472NxuSRS1rUcG/
         oaaA==
X-Received: by 10.66.194.201 with SMTP id hy9mr13707154pac.140.1433589986277;
        Sat, 06 Jun 2015 04:26:26 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9374291pds.92.2015.06.06.04.26.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 04:26:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <55729B78.1070207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270914>

On 06/06/2015 12:34 PM, Karthik Nayak wrote:
> Version for of this patch can be found here :
> http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
>
> Changes in this version:
> *    Rename functions to better suit the code.
> *    implement filter_refs()
> *    use FLEX_ARRAY for refname
> *    other small changes

I request that this series be ignored, will push again. I hadn't rebased 
on master (latest), there'll be merge conflicts.
Sorry for the inconvenience.

-- 
Regards,
Karthik
