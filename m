From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 20:00:04 +0200
Message-ID: <554CF9A4.4050103@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com> <xmqqegmucqyh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 08 20:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqmZR-0004HR-JX
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbbEHSAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 14:00:13 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37807 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbbEHSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:00:08 -0400
Received: by widdi4 with SMTP id di4so35812396wid.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5w3bGLTK8Zq0QR8W3y6kI3jGvgZKw35MgmJtgIRaHtg=;
        b=dlp979nY0P/MqTrMXR+CAkHEEwgja55ZHF6zhRLDFMrgmZOx02PSdj3/v8jqF0Rfn+
         Um07jakxHD6/oheM3nwwPnBEotIoNVxJF2ajmCwXK3zXgeRbTI9HxGeUgU5L2HOc+NkI
         JV610vjpvS8+eqybhTmEa15c5x9Es7qlu/ov853B44UYhyThuclBvto94bwRtiCzbAWN
         1nYJQo1F53dEdXnbbA5GcpTvHChzc6PyYsxPjNjwa9n21DfbdChA95LFKyACfHO1DUE5
         d3NzJ/yOsebm2VEbMpmlZ25YnRJ4j4ujk8Ktu66RDOEn4BY5Wx4PFybvZ3DDJLe5hGA6
         Nd1A==
X-Received: by 10.180.231.4 with SMTP id tc4mr68519wic.27.1431108006653;
        Fri, 08 May 2015 11:00:06 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id l3sm10407354wib.11.2015.05.08.11.00.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 11:00:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqegmucqyh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268636>

Hi Junio,

A preliminary question to prepare the next round (v5) of this patch:

All versions of these patches were based upon the tip of 'master' 2.4.0
(3d4a3ff).

Should I rebase subsequent patches on top of 'next' ?

S=C3=A9bastien
