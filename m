From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Licensing and the library version of git
Date: Wed, 26 Jul 2006 17:36:16 -0400
Message-ID: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 26 23:36:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5r3F-0001GB-IZ
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWGZVgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 17:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWGZVgS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 17:36:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:44851 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030271AbWGZVgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 17:36:18 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3373559ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 14:36:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZLP1kkuOB0lro3IaNw4ZqZhXCbdr7TUhwzd/83bu+mS5r34xR1QJra3Na8Vk+PgRi+UVASAze264IpxKu34AFAXxa8O8XFl0/5ocKBsfWY1T5LSAHBzQ51d9AtCiKRogddxfRhw7NHZV94j9cDTe+Ry3lvegE7p6H5wb0qfOyF4=
Received: by 10.78.175.14 with SMTP id x14mr3485023hue;
        Wed, 26 Jul 2006 14:36:16 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 14:36:16 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24253>

Can the library version of git be licensed LGPL instead of GPL? If it
is GPL then it can't be linked into non-GPL projects like Eclipse.

-- 
Jon Smirl
jonsmirl@gmail.com
