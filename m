From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Wed, 22 Jan 2014 13:53:26 +0100
Message-ID: <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com> <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 22 13:53:56 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W5xJc-0000IX-Dq
	for glk-linux-kernel-3@plane.gmane.org; Wed, 22 Jan 2014 13:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbaAVMxu (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 22 Jan 2014 07:53:50 -0500
Received: from mail-ve0-f172.google.com ([209.85.128.172]:64988 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbaAVMxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jan 2014 07:53:47 -0500
Received: by mail-ve0-f172.google.com with SMTP id c14so192531vea.17
        for <multiple recipients>; Wed, 22 Jan 2014 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ce/bZyyPLFqktWhKivGC1tlMEqVn7jmN+EzKxLZ5QUQ=;
        b=R7jDvSWdgzLp54d9SgaYPxTwXwHn1ZiKLW3TLlL/wDw4ll4iQpU4k2FRU8w9rZv2T3
         vxhON6GiHgOaZUmi3yX1/SgBcrOV/q9Tk/shIujg4+D29aiYi683pK8UzMQdJAKPNXBo
         xfq1nJVhBxz9La6yXsrpKBmzW4x8guv99hC8/fpxA0bQmvMMF8cl8X/Qf00ISzcXxkky
         exVdhFe/VsKx8IK66Dbak9jNW5B1G6Za6vjPbzxEUZYaXiyOKomTT853ZHnzji5yo9xp
         DGQOMwI1iJaFLULJfmBUKOv550dyiK6LS8YfaAhvvuyAGJQ2BE903aytDcqFcF8RYY3C
         ddhg==
X-Received: by 10.58.66.137 with SMTP id f9mr766984vet.11.1390395226904; Wed,
 22 Jan 2014 04:53:46 -0800 (PST)
Received: by 10.58.198.193 with HTTP; Wed, 22 Jan 2014 04:53:26 -0800 (PST)
In-Reply-To: <xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240824>

Will there be any change on how tarballs are distributed, taking into
account that Google will be shutting down Google Code Downloads
section[1][2]?

Cheers

Javier Domingo Cansino

[1] Google Code download service change announcement:
http://google-opensource.blogspot.se/2013/05/a-change-to-google-code-download-service.html
[2] Google Code download section FAQ:
https://code.google.com/p/support/wiki/DownloadsFAQ
