From: Adam Hunt <kinema@gmail.com>
Subject: /etc in git?
Date: Wed, 18 Jan 2006 19:43:44 -0800
Message-ID: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jan 19 04:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzQiG-00048L-3l
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 04:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWASDns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 22:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWASDns
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 22:43:48 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:7276 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030483AbWASDns convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 22:43:48 -0500
Received: by uproxy.gmail.com with SMTP id s2so71052uge
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 19:43:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vm7hCv17Z7OO07l87IDKBEnua9tn8jm0GfoptM1zgLSfIuTobwT+WxV49t2RCzobsv9z1M2wukJPLUf6Vz7vL7FTOq7GBir92uncDf7dnW2s8q9vAol1nCZaLNJyeNVgIOnpKWBsT16/dUs8po8IWgqys5yxwoDvDjlA9eifK/I=
Received: by 10.49.20.12 with SMTP id x12mr8068nfi;
        Wed, 18 Jan 2006 19:43:44 -0800 (PST)
Received: by 10.48.162.7 with HTTP; Wed, 18 Jan 2006 19:43:44 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14881>

I was thinking about puting my /etc in SVN or CVS but then I got to
thinking about git?  Has anyone ever tried to version their /ect with
git?

--adam
