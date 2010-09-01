From: Shivdas Gujare <shivdas.tech@gmail.com>
Subject: html page display via cgit
Date: Wed, 1 Sep 2010 15:02:23 +0530
Message-ID: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shivdas Gujare <shivdas.tech@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 11:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqjgE-0001p9-G7
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 11:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab0IAJcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 05:32:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53152 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab0IAJcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 05:32:24 -0400
Received: by vws3 with SMTP id 3so6305488vws.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ym7mSqcKBxTlvdBxlqb25IRyh0XnGlqc3NSQMZX4x5A=;
        b=oBg9NJl3Q5ZdK94CXs1wDLB4L/YOBdAvGwyozh6xmX/LyKTt1h7uIaDW3jVr3SxBpL
         vfC1MiGAzHqFdEqfBJHWpwp11JeGRMZ5Ke3I6vFYj4NTlE4DuxlpdGxY7+A/yuXzcB8k
         F7wD6yJbPnxR6vP5INIbHxZU2OWSefzIKvVU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=s1OjtNQ/bdcJ2BL8XOh7ih7mn8XY8lm4WmUVAkoEgdzml/J9aghQcxpkPBHGXmJFVu
         klrFfkkhngtkRjIfgDAF3k2vuoFZLHf3hg/d5poXYH7CLFX2TzREporfej2IYInRQaJv
         efSpl4bVE5PoA1ZVpaqt5ykEyZ+WptT+BhmpE=
Received: by 10.220.158.9 with SMTP id d9mr4374389vcx.33.1283333543277; Wed,
 01 Sep 2010 02:32:23 -0700 (PDT)
Received: by 10.220.177.141 with HTTP; Wed, 1 Sep 2010 02:32:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155027>

Hi All,

I hope, this is the right mailing list for cgit as well.
I am trying to add some "html logs" inside cgit, but I can't open
these logs via cgit inside firefox, i.e. cgit open every files in
"plain" format,
would like to know if it is possible to open "html" pages inside cgit
so that if I click on html page added into git, it opens in html and
not in plain format.

for example:
if I click on "download.html" from
"http://cgit.freedesktop.org/~lb/mesa/tree/docs" it shows a raw file
as "http://cgit.freedesktop.org/~lb/mesa/tree/docs/download.html"
and if I click on "plain" it opens in firefox like
"http://cgit.freedesktop.org/~lb/mesa/plain/docs/download.html"
but here I am trying to open this "download.html" inside cgit so that
I can view it like html web page and not as "plain" text file.

Thanks for any help or pointers.

Thanks and Regards,
Shivdas Gujare
