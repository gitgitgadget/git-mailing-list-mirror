From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v9 5/5] help: respect new common command grouping
Date: Wed, 20 May 2015 23:42:12 +0200
Message-ID: <555CFFB4.1040406@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com> <1432149781-24596-6-git-send-email-sebastien.guimmara@gmail.com> <555CFEF4.5000002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 23:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBks-0002pn-HR
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbbETVmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 17:42:18 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33462 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbETVmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:42:16 -0400
Received: by wgjc11 with SMTP id c11so66496164wgj.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GRslUL4mYoPUe3aMigRTfPh+AhYbqql6uZW+gBQA5cw=;
        b=j2p5kDHMBPL2E8d0cznbzslGdUFYiGL4LAjV8LkdUKkSaxET1c5K/fyy0aMast6qBj
         oOGIQU3T1b6JvdsDRPB3S3hB+fc/7BOmMhsx568Oi/LK+c5UNt96Tmzy4YEcv+dP8mCn
         JqLWXCjWkEEslxNdXlRS7U3m1sGDuBcx3V1CjuG1hkIbZBSvA6rp+tbtWyhEDEvwextL
         xNpJff2PD2klDExghdBYMTGmd3Ey5+413ifyc49iCYB8uBLyTyULmLCr45uyAEPzIO/A
         v2ztftGaGx/LZq1yiYhjWvKzWjHkJ2p16LUiLkNmb3r7BGQhg3ILr80+zz1x1yDMGD/Q
         X+pA==
X-Received: by 10.194.222.137 with SMTP id qm9mr69409449wjc.43.1432158135828;
        Wed, 20 May 2015 14:42:15 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id ex5sm5474190wib.2.2015.05.20.14.42.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 14:42:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <555CFEF4.5000002@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269530>

On 05/20/2015 11:39 PM, Ramsay Jones wrote:
> On 20/05/15 20:23, S=C3=A9bastien Guimmara wrote:
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> This should be (at most) 'Helped-by:' - my 'contribution' was
> so minor that even a 'Helped-by:' is generous! :-D
>
> ATB,
> Ramsay Jones

Ha! I'm still not very comfortable with picking the right
attribution...
