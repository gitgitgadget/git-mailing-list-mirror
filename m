From: Gerardo Di Iorio <arete74@gmail.com>
Subject: git push very slow
Date: Mon, 1 Mar 2010 15:36:23 +0100
Message-ID: <87e948d31003010636u3084d7auf87794052ee3fd3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 15:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm6jp-0001tu-3E
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 15:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab0CAOg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 09:36:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:19047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0CAOgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 09:36:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so860723fgg.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 06:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=e6aDHJir35DAq+JtGb4NmSeq7u8J2V2B+2FRonyWbXk=;
        b=rJImZm5bi2kR80hWtRqmc/BrvpOySKVtORE2H4KCT0vm5aoAuIPZiR6UoucqBBCglr
         2C5XHsv3s+oIUvNs0Fn30LRmUXjvqqDaQ8SPZ5Hy56dh/psaRl1zTpqUdl88mBvfU6AA
         Qyb5lTIm6Zf+QTYX87T90El3t/cj0UXmL6JXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WAdXtK3bjcPxbCW0BV4mCgnZqQk48qNidVov4u5JzjxU1EdvjnVEkWlW3U2u7FrC7V
         ONb78IC7xKQZvlEVHbuzahBi40FggoNgjG+N4jeTTq4Hc8RnnFgd4q6zbuTlsYMBm+i/
         BN7S8T/y75U9Ffgx0JtMZ2X/uCxuBe/oDVSLs=
Received: by 10.239.193.148 with SMTP id j20mr505820hbi.40.1267454183912; Mon, 
	01 Mar 2010 06:36:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141321>

Hi,
i have setup an git repository for general backup of my personal file.
I have 10G of data and the git push is very slow while "compressing object".

Who is possible speed it?


-- 
http://www.gerardodiiorio.com
