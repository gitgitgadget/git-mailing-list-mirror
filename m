From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] Documentation/git-am: Document supported --patch-format
 options
Date: Mon, 17 Mar 2014 20:35:55 +1300
Message-ID: <5326A5DB.5070407@gmail.com>
References: <1394509917-9679-1-git-send-email-judge.packham@gmail.com>	<532559D2.3050802@gmail.com> <7vlhw92us1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPS5i-0004i6-33
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 08:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbaCQHgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 03:36:05 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51549 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbaCQHgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 03:36:04 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so5246879pde.11
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LlnIbwWIYmMxMZsURlSnY2zcKNw1h/8FvwB3SxxRjTg=;
        b=Jk6H23B1LLW04hCQpGYJbq9KHhChCwzOLFTlI2gx6HmNVW1bazoNCBlmEDqL9fJkji
         rrdk2Nb8DagZFHAYvecuYnqsDDoWiU9+ChxvlDzEUyF8CIvHoqadvF5p3jKLDZcw77FL
         YwkReFWY7s8cdaaXVb0vS0rLKqC6jHcLYLxF/5f205IqF/wmQMfA54+scHcZoaCN+kGA
         pLD9jj/BDOhr29DI4GRIqXQ0m1hqXd3d6at2ZvnR5BOTf5fSP7/A3nIOPuT7H2T2sDO5
         9PO51yPy1fsW9xKkuJmvR4OVyKQKeTz7VjkQk6CO7pTCIQDOrJ0hr28Wbx70P8Z0x79Q
         y5Og==
X-Received: by 10.66.158.132 with SMTP id wu4mr24503193pab.66.1395041763049;
        Mon, 17 Mar 2014 00:36:03 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id gg3sm40582398pbc.34.2014.03.17.00.35.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 00:35:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <7vlhw92us1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244228>

On 17/03/14 19:39, Junio C Hamano wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> Ping?
> 
> Hasn't it been already cooking in 'next' for a few days?
> 

Indeed I think I missed a "What's cooking". Do you want me to submit a
fixup for the spelling mistake?
