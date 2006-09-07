From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 22:39:02 -0700
Message-ID: <44FFB076.4020408@gmail.com>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061617m6783d6c4xaca2f9575e12d455@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 07:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLCbh-0005wz-Ru
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 07:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWIGFjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWIGFjK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 01:39:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:36366 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161130AbWIGFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 01:39:07 -0400
Received: by wx-out-0506.google.com with SMTP id s14so114475wxc
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 22:39:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bbmz5o5wWFo4ixgTdQpqN4ESFIzngTKdQ9Jll7KkFmszTKejpDqW4OeyJ9xgZExLmHOmZMxgpXhK5si3HJi2zPH42eFtotwhmB46jy1T4b79HUwbi6s1hTwbUcmB2UKnP9p4/5f70MKpggFUNRcoSw7KKAftYyFHrVsYQxmXvZk=
Received: by 10.70.32.2 with SMTP id f2mr573349wxf;
        Wed, 06 Sep 2006 22:39:06 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id h37sm452904wxd.2006.09.06.22.39.05;
        Wed, 06 Sep 2006 22:39:06 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
In-Reply-To: <9e4733910609061617m6783d6c4xaca2f9575e12d455@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26594>

Jon Smirl wrote:
> If you need more data to play with you can download the Mozilla pack
> file from here.

Results are about the same as for the other pack files.


pack-a80bec5339b6c50e9f3c8b0dce3e2175cd89b12f.pack

BLOB  :       49860
COMMIT:      197613
DELTA :     1560153
TAG   :        1203
TREE  :      154496
======   ==========
Total :     1963325

Gitzilla_1:   443428349        32   443428317    -7775014   -3.9601
-4.9835
Gitzilla_2:   442177053        32   442177021    -9026310   -4.5975
-5.7855
Pack_2    :   451203363        32   451203331           0    0.0000
0.0000
Pack_3    :   451010859        32   451010827     -192504   -0.0980
-0.1234
