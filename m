From: Whymarrh Whitby <whymarrh.whitby@gmail.com>
Subject: Adding back empty sample hooks
Date: Fri, 21 Feb 2014 20:02:51 -0330
Message-ID: <CAL5BTm5xuDHDNdszUaZpPKhsENNy4KvrD=_fH68yOi+vrWe4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 00:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGzaT-0005Bh-81
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 00:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaBUXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 18:32:52 -0500
Received: from mail-qa0-f66.google.com ([209.85.216.66]:33736 "EHLO
	mail-qa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbaBUXcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 18:32:52 -0500
Received: by mail-qa0-f66.google.com with SMTP id f11so1373891qae.5
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 15:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=exyrdt9qYaQKopgWMHp0lCip+Y4HyFLIHZD5HGkAvIY=;
        b=JOVLIUqGnziUNOOuON16iHoKxuqMX1NwCEIlVKO7D0Gx/rvFRV7VVC+0C2F6yQmAjy
         xvS5ws1lg1Z6rhrv0kutjFsx3fuIMbdqStJIf7zSWG/AfXA56Xn7bAM3rugO+jq2Ifia
         52jLNiE7tknonFCKVXkFiyYLUVaw0Q8IW7GsldmgBPyxCjzWpqCLdNRD9feWSW8fh3Xi
         llKB1m8LCqkQp97KE+xFrE+3PYjK1TJSZR082jpVNfjwdDzpLxO69Oxm92rIAAcH9CrO
         JzsRzKZMUWkPqH1lLk7kEYZQnwG7AHPimD5OfLOMzotFJ5cJHGkrni1PYwcSuub4SUt5
         no6g==
X-Received: by 10.224.56.5 with SMTP id w5mr13836858qag.60.1393025571721; Fri,
 21 Feb 2014 15:32:51 -0800 (PST)
Received: by 10.140.91.161 with HTTP; Fri, 21 Feb 2014 15:32:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242494>

Hi folks,

Would there be interest in adding back the sample hooks that were
removed in [8d714b11df][1]. I think that they are helpful if only as a
quick reference showing what hooks are possible. (As well spelling
receive incorrectly is a source of confusion (I think), but that's not
a good argument.)

Thanks!

Whymarrh

    [1]:https://github.com/git/git/commit/8d714b11df2b65e5f4272c1616e561930010be90
