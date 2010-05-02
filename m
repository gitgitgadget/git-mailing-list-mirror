From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] blame: add a range option to -L
Date: Sun, 2 May 2010 07:44:09 -0500
Message-ID: <y2mb4087cc51005020544i7dd5c922y15aab5f64797193d@mail.gmail.com>
References: <1272662989-563-1-git-send-email-wfp5p@virginia.edu> 
	<20100502091433.GA1854@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Pemberton <wfp5p@virginia.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 14:44:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8YXP-0006De-8V
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 14:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0EBMob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 08:44:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:26905 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab0EBMoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 08:44:30 -0400
Received: by fg-out-1718.google.com with SMTP id d23so712963fga.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cSv8dwQ2gktAEH2Hskfdzk2zY+YkD5RizG5hz5Wf03U=;
        b=XBLzc2+kA1Sin7uRL8xEA7wFToaWhf6ZJ7PBOObyB5ghn3L6MPebFzN5fI16PKlhif
         6D+BVLDTyeA80rSXV1J1UeiEHsAUSyLDRqejXyAvw9A4ARjERORVt8U/oYnPc4kS7JaD
         7R8YZMmqK8K2QSigVsdC1QNKjEvvIH87RIGMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w1I3QAsRgeFMbdck+EufN6yJn+trY3gYjfpDc1uHYaDKDNRj0Q051r/C7oW5aB4JHW
         BuZgfvxkOANMUJvyYKVFRGgxom+dOr2nXXRBVJgx8kvu3rhnUXejrp5tUYEku0Xjv5TW
         khtSlxvHfE9lZsW8d2+8vrhCyQkB3gaEJjt3c=
Received: by 10.239.189.145 with SMTP id t17mr443625hbh.81.1272804269197; Sun, 
	02 May 2010 05:44:29 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Sun, 2 May 2010 05:44:09 -0700 (PDT)
In-Reply-To: <20100502091433.GA1854@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146169>

On Sun, May 2, 2010 at 04:14, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>
> From too much exposure to subversion, the r suggests =E2=80=9Crevisio=
n=E2=80=9D.
> But =C2=B1 is too hard to type, so I guess r will have to do.

How about '=3D' ?

How about '%' (for above and below)?
