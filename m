From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v9 3/5] generate-cmdlist: parse common group commands
Date: Wed, 20 May 2015 21:27:27 +0200
Message-ID: <555CE01F.806@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com> <1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:27:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9eR-0004tu-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbETT1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:27:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33879 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbETT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:27:30 -0400
Received: by wicmc15 with SMTP id mc15so159669624wic.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=B2vxeUKCxbPLBlcggWI4bC3ttttL9Cs60WLjjI2iklo=;
        b=mZN729uf0RPN922RQnVKwRnUjmeVucQ02LbMY2EpAr/lGGvuDLCfcpu+uUSo0t03qE
         jmwnGUlkfMgZnI2gNIZ212knyjM39ohONgSYm07nMyvpr4uvqO3Q2pBmQ/WLujmIqaNa
         Le6Hjyk/UzOfMyPTqTeWUp7IYg5EPZDtd+nbDQ9rI+70KTVHJTTVab/VCzjdqeelTmtg
         gTUpBYl4xXCTt0JLBV3eVPV7MtVMu4Ce2YsrYNe+AoIXqsMitMJkpCMVv6RRQnm89oMy
         tDk8X9DCiUH8XHBjX72csNdQ+gKTLu8cpHg4u7NPZMaUP+XVUMfjIRoUPBTmoLfvQch3
         fMKg==
X-Received: by 10.194.191.164 with SMTP id gz4mr66696259wjc.15.1432150049633;
        Wed, 20 May 2015 12:27:29 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id o5sm5105071wia.0.2015.05.20.12.27.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 12:27:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269502>

On 05/20/2015 09:22 PM, S=C3=A9bastien Guimmara wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>

It looks like 'git send-email' got confused with the CC field.
I'm sorry for that.
