From: Gonsolo <gonsolo@gmail.com>
Subject: Undocumented option in git-svn
Date: Tue, 04 Aug 2009 11:37:45 +0200
Message-ID: <4A780169.90109@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 11:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYGSz-0002X3-Bg
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbZHDJht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 05:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbZHDJht
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:37:49 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45744 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbZHDJhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 05:37:48 -0400
Received: by fxm17 with SMTP id 17so3156926fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Uor/fZByxW8UyPZ/u8H2+7AIyoJ7ADHgl2MYX+xfZv0=;
        b=WV2PbJIpTBuj6Eq0qiYUhTx8v2BAJ1Q3K42ot6+xlaOHypeze6Q9gyJmdxNjsvaGR8
         JQ00tJKL6tgCHuL8hrUqmR2kcfdVER24fNKaje/C+ZMCCTdIYnBup3KGbOaH9H6bQFC6
         rx18u58TmbZcfjLE77NaWSmSNU/FDp6c1BP9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=espdf5yDbHY/XgVWZc6RuohnC4kj62Ekr4TFBdQRJmykEjniFX1Lz/gdK1zFTzyI2O
         LHU+5ejAtDKdoQl0gTjYmKiPLboBAW/IdIvVvslCwu4NqaxFokV/6yItTlrqRCp1qsGZ
         krWkk1z6lPleJqoRgOvp/xxXJ4ljhJ0J3vL9k=
Received: by 10.103.247.14 with SMTP id z14mr1930832mur.72.1249378668413;
        Tue, 04 Aug 2009 02:37:48 -0700 (PDT)
Received: from ?192.168.2.100? (port-92-206-181-200.dynamic.qsc.de [92.206.181.200])
        by mx.google.com with ESMTPS id t10sm44481679muh.0.2009.08.04.02.37.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 02:37:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124774>

log-window-size is not documented in the manpage.

Thank you,

g
