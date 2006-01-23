From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] quilt2git / git2quilt
Date: Mon, 23 Jan 2006 11:33:47 +0900
Message-ID: <43D4408B.8050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 23 03:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0rXG-00043J-Bg
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 03:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWAWCdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWAWCdz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 21:33:55 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:45575 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWAWCdx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 21:33:53 -0500
Received: by wproxy.gmail.com with SMTP id 57so802733wri
        for <git@vger.kernel.org>; Sun, 22 Jan 2006 18:33:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=JL8Mn6znR+vZ/auRtHJtP+7CAR6IP+rKwN6K0lSFZp+gSIqRFXjCCxk6wktRyLuX+JJ9GH3qLc/fC0JTMSFRM6+0QqlbIRiN+Qaumz9H1E0LVCio2XUJbZ7MEDO+caIhGyONiSpS5dO9GCd+650YZSzAubOa0zw9nblYcQJdUls=
Received: by 10.54.77.19 with SMTP id z19mr5127975wra;
        Sun, 22 Jan 2006 18:33:52 -0800 (PST)
Received: from htj.dyndns.org ( [221.139.199.69])
        by mx.gmail.com with ESMTP id 40sm560629wrl.2006.01.22.18.33.51;
        Sun, 22 Jan 2006 18:33:52 -0800 (PST)
Received: from [127.0.0.1] (htj.dyndns.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htj.dyndns.org (Postfix) with ESMTP id 33C12184158;
	Mon, 23 Jan 2006 11:33:48 +0900 (KST)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15073>

Hello, all.

I've made up two little perl scripts to convert back and forth between 
quilt patch series and git commit series.  Hope someone finds it useful.

http://home-tj.org/wiki/index.php/Misc

Thanks.

-- 
tejun
