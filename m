From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] Documentation/difftool: add deltawalker to list of valid
 diff tools
Date: Thu, 15 Mar 2012 18:21:36 -0400
Message-ID: <CAFoueth3kwrm7rbLnN0sipOvFUgFW_YdRS8Z0+Uk+puFsaRSLg@mail.gmail.com>
References: <1331828906-5943-1-git-send-email-tim.henigan@gmail.com>
	<7v3999k2h5.fsf@alter.siamese.dyndns.org>
	<7vobrxik6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:21:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8J3G-0007xZ-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760807Ab2COWVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:21:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39716 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab2COWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:21:37 -0400
Received: by iagz16 with SMTP id z16so4471847iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rMznNyG0zdP+F1QL6Y1rZ7Yl2tBsSU4hlhiRbJj24j4=;
        b=RSVCj1Yzhh8eodUrxk2TmsRrUBXz5I+lmoE1hZLA97h0vDxxWbjp6tWha91D1RjCOF
         ef7fABszs+PvndsKyevu45yFJlV0oew/F2kIxzIEQX6w5/v6nkHAA0NIGnFwcbnRb9Zq
         UdX4qiNIaM2TbjSK+aPIhOZIfmsuZmtE2JyVT/inOKCu1+7zLzf8kLivfUGxa3DxxQQQ
         yWyan6CUNrzsnE1b2HB0id7naK0LKtT+tq61KrQUOV4w3PXEo+mm2G9d3qmkoVPjtm5K
         e+DUE6vkVIbgw9eUjLBhVJVAFlX6M1kpalvlJY/ovEC+QCSvqvz3vO4adxiTypF36PRU
         IXMQ==
Received: by 10.50.149.131 with SMTP id ua3mr18257020igb.41.1331850096741;
 Thu, 15 Mar 2012 15:21:36 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Thu, 15 Mar 2012 15:21:36 -0700 (PDT)
In-Reply-To: <7vobrxik6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193232>

On Thu, Mar 15, 2012 at 6:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The above is the longer-term direction. I'll apply your patch to add
> another new tool to the existing list for 1.7.10.

I am almost done with a patch to do this...I was planning to send it
in the next few minutes.

Thanks,
Tim
