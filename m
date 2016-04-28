From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] Fixed grammar mistake in the french localization
Date: Thu, 28 Apr 2016 22:05:46 +0200
Message-ID: <871t5pv6qt.fsf@gmail.com>
References: <01020153f9be55b1-84948015-9e20-43da-9f9b-d2658d744c64-000000@eu-west-1.amazonses.com>
	<87bn4tzn1c.fsf@gmail.com> <4943119.TLAOheZWxB@cayenne>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antonin <antonin@delpeuch.eu>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avsCB-0006nf-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbcD1UFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 16:05:51 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36785 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbcD1UFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 16:05:50 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so2780958wmn.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=A8RSEkW8f1TcrNm57VVtCy5H/TYIBRsrEiRgKAx6n8M=;
        b=FmtFc/GsBVISePOu0OOYnNCMiahRO/12LF/G25z/bLz3AN12hfLs2MyL7kxxPz2bjh
         uUiArFFRxiBpPAPw1xX4DCf3F2m0Mnb1u1GPMgXl/4Ik+sW7hSBVEWzTznmz5ljazirQ
         L5/vtQpg62ceIEdZ2AZ/RpHSacapsojKYQRCGJd4eDTUuCtAI5g4yKjH54cGKQcJXA9f
         sPc2aEA6JeeBEoqYh6iXrPODR3L+BVn2VzTHDccVyfTx3ubtHAJSOQVBv8JSVVu7YXqw
         yzC6w1FvJIV0kxs0GWnK+S2O3ni+X1ijDuaBDUp1LNVkcpoE6ydj4XjNK+FRZqxyVgH3
         jt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=A8RSEkW8f1TcrNm57VVtCy5H/TYIBRsrEiRgKAx6n8M=;
        b=W2uikrotWUU1U5tkUA6v+ZwDtrBFdUdR2nmjp5j8kf4nv6SqPXsOdpp/jD2UdzAkLR
         FxfMVLyNEogoLOEwlK47kiHmMWAGrekkZkpQZ2BqCElf5hyT0L6sdx25XETcOdlIhLio
         yHQ0EaCcmZg5kacdrNTyu7PTogDPiUUYAJnFhkkG92UluFFpKIYJDC8XtpOzaCYZuyrB
         STU2G321yp9fGHrY2/ixRtNG+I0gosKrJ4bznI7ej1ZOEZPA8dsH65MqGfHINMlNJQk6
         9I0j8F+/17qTwGq0N9vPw7h3QvwPY0rvBNzmBmRfjqCY2R+HRvnqyxV3Qfz4T2Z5ERG1
         c4Yw==
X-Gm-Message-State: AOPr4FW+ejMSnJ+Kh+lQI4zxURDE1wXZTUP86KfqEhWg/Sn3Uhvw3n8wQWz8dRE1QsYKzg==
X-Received: by 10.28.130.6 with SMTP id e6mr19633930wmd.94.1461873948580;
        Thu, 28 Apr 2016 13:05:48 -0700 (PDT)
Received: from ralf-ubuntu (cable-82-119-19-197.cust.telecolumbus.net. [82.119.19.197])
        by smtp.gmail.com with ESMTPSA id d79sm36594592wmi.23.2016.04.28.13.05.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 13:05:47 -0700 (PDT)
In-Reply-To: <4943119.TLAOheZWxB@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Thu, 28 Apr 2016 21:15:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292948>

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Cherry-picked, fixed and PR to Jiang Xin
>

Thanks

> JN
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
