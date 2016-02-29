From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: GSoC 2016 Microproject
Date: Mon, 29 Feb 2016 20:21:41 +0530
Message-ID: <56D45AFD.2060200@gmail.com>
References: <56D19EF9.3070702@gmail.com> <vpq8u26qo3y.fsf@anie.imag.fr>
 <56D1BEC8.9010302@gmail.com> <vpq1t7yqgi4.fsf@anie.imag.fr>
 <56D2C828.6010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 15:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaPBH-0000i9-J9
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 15:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcB2OwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 09:52:12 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35968 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcB2OwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 09:52:11 -0500
Received: by mail-pf0-f182.google.com with SMTP id t66so27597304pfb.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 06:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:references:cc:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Hwyef/fsAzAf1DnRxKu0D4b47RZeXSL5HJusyk0j8fM=;
        b=aoVoTyj6QKNUVtQcnriwRw6pfi7Mchiw18ngJftwcQzLff8rPlylKB1G8zp1xxnsow
         wnLswkrmwOc1tqiesxsLbGNprtm32/sD4ueuyoQ33R1kIaPGYE1C3KNRU+VtxCj2UIu2
         UnuVZBqHcUhCJp35o+LJQdYmPvtujpAuk/peSEcuPCo/HFx6q7lu3k8u6u1ViGZVrpCp
         kreQAsxe+ITI+F/FotoXqiAycTYLQKONj4Jrx/tnhHwVJcFv2IlsOKB5BBxnX1k34jnl
         Ab62Ic0Lbg8AWqnxigYd0AJZHeg6FoW4nDTeYln2gkQz8/SDpg511Q6V72DUblTE97Us
         f/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:references:cc:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Hwyef/fsAzAf1DnRxKu0D4b47RZeXSL5HJusyk0j8fM=;
        b=dYLp4e73fyX/ih+1QHL3J3d6lr0G1qwCrRINGqKYNh0HYyZ0RhVXNXGeERqyDA72xX
         RnauprxosI3j46hMYaDpG7iU17RTc2h9sG3/KzUnwM/QSqeSEWcdn9WpyS8USfcas+sG
         VmFtTkFQTf2C0ObWLq3CWLJldazBafwHJSgd4E9JzXYpp++FRv5NdaRm6swQU/UxH+Y4
         AVH6qQd2RPwJClonX1ZbZ8ACkAaGeqCeVm1ZO+imeVW645tmbwAvM9nPknFtilSKIZ79
         YumlWRoDO5SzhPmN9slCWWePxUS0MJ8iczO37FO5P1EpQc6VbIuhHXjdFsZ3DPk7EmVQ
         rZiQ==
X-Gm-Message-State: AD7BkJK+zF5nxJgD3yTvAs+7+c8orwO9F8LdU1zcXrKPp686cV++8LUDpvUV5SlDM+TjpQ==
X-Received: by 10.98.19.199 with SMTP id 68mr5270997pft.31.1456757530236;
        Mon, 29 Feb 2016 06:52:10 -0800 (PST)
Received: from [192.168.1.10] ([182.64.202.34])
        by smtp.gmail.com with ESMTPSA id d65sm38753941pfb.74.2016.02.29.06.52.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 06:52:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56D2C828.6010901@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287841>

Hi,
Should I make a patch for this and submit it for discussion on the mailing list?


Regards,
Sidhant Sharma [:tk]
