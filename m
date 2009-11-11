From: Dilip M <dilipm79@gmail.com>
Subject: tracking binaries - help needed
Date: Wed, 11 Nov 2009 16:30:16 +0530
Message-ID: <c94f8e120911110300j7727345cxf9fdfe4e6b86b137@mail.gmail.com>
References: <c94f8e120911102245gd7cce07mdb87fdb870880530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 12:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8B1W-0007dR-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 12:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbZKKLFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 06:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbZKKLFw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 06:05:52 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:54791 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZKKLFv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 06:05:51 -0500
Received: by pzk26 with SMTP id 26so676094pzk.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=52PXhSjlc6gxK6gRq4egLBEeSt6mgtoPYz3Cskg3/4k=;
        b=QAriopaIltYtKlcz4BDvbrmuuXcj9ykLmJSVVPuBrf4QV+cgOGlRiEydpFCH6v/348
         /w4hczLL0Ibt18ABQPQSEXXoZbnJbMQ4mBYEZo2GJ7POhqHAYhrgNC8gYurxevtQypGQ
         DNjd1VlByStRQanIwKofwp4ffbYVjx/STZYnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=SrQX8o8oACnFdvMMq4zmwbg/WX/3g2cicqfj8SST1RBeowFy34hkDC7MmgX7ivAoT7
         QuzMYwqjmjjwONRpP5tHXtJzZ/WH0+VDI+5CUnSBzcvJeOHUjp2ShuEAiRpjgesq66wN
         /eQRxLXPoodD6OHCIU9oWDwLQiOe+3hUU0tj4=
Received: by 10.140.191.17 with SMTP id o17mr86598rvf.7.1257937236097; Wed, 11 
	Nov 2009 03:00:36 -0800 (PST)
In-Reply-To: <c94f8e120911102245gd7cce07mdb87fdb870880530@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132640>

Hello,

I know, tracking bin are not good, but there will be still some docs wh=
ich has
to be versioned.

I am using, msysgit.git version 1.6.5.1.1367.gcd48.

I just did a add of some MS EXCEL file and =A0When even I open and clos=
e these
files, git status shows these files as 'modified'

How can I deal with these files?

I believe its the same case if I have repo on UNIX too.



--
Dilip
