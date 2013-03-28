From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] gitk: Move hard-coded colors to .gitk
Date: Thu, 28 Mar 2013 20:53:43 +0530
Message-ID: <CALkWK0mt1cZ22xXFXywQNk7EnZ22kq0KJfbr-GTrSg6iMXF5Yw@mail.gmail.com>
References: <1364391651-5896-1-git-send-email-gauthier@ostervall.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, paulus@samba.org,
	patthoyts@users.sourceforge.net
To: =?UTF-8?Q?Gauthier_=C3=96stervall?= <gauthier@ostervall.se>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:24:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEgs-0000wF-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3C1PYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 11:24:05 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:40822 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3C1PYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 11:24:03 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so8284541iag.17
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=LLhTLCBTovhGXIdpDDHrwGp+y8YD+GVYRWg1aAYdbpI=;
        b=JTGYaDU6eGGk0MuKjoBF80zssgwT399mM+7yk2vQQCSqTflXowOl3GlzOWJ5fDIOLm
         0WxYn4i6QotvXDOJMZ4xNDdhi/I8KZ0VtTCBnYStZ85AMib1t+LOi2I4mFTAEHPUm53O
         hj+bFdbJ1XcMrm9peRPaiGcM6CZmMVXYIeppybycNMZ/VNRuNJaw3BzjGrgRalmk/uE3
         or3sty2es9XjOa4uX1fLgCEjqnr9f1W1YAC97kaqhbUq6PijTF6q5rLKmZGrQnoWoHsR
         gkiaYyGquPkgZ4dHSyxfCqSJaeoqwPkM/gm0SPIdSlV4F74CNXjVb8yiBnrzV+LwbHrI
         MM7Q==
X-Received: by 10.50.17.201 with SMTP id q9mr6929712igd.107.1364484243244;
 Thu, 28 Mar 2013 08:24:03 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 28 Mar 2013 08:23:43 -0700 (PDT)
In-Reply-To: <1364391651-5896-1-git-send-email-gauthier@ostervall.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219408>

Gauthier =C3=96stervall wrote:
> Screenshot of my current coloring setup using this patch, based on
> zenburn:
> http://s11.postimg.org/hozbtsfj7/gitk_zenburn.png
> And the .gitk used to that end:
> https://gist.github.com/fleutot/5253281

This is a really cool color theme.  Would we consider shipping some
themes with gitk, in contrib/ perhaps?
