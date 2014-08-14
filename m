From: lpicquet <lpicquet@gmail.com>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Thu, 14 Aug 2014 03:23:14 -0700 (PDT)
Message-ID: <1408011794311-7616843.post@n2.nabble.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com> <1343637600904-7564056.post@n2.nabble.com> <CAJo=hJtynNo3SPmM4vmmsS3b7PTUwOcQpHPYh0_sPWFWL-4HMA@mail.gmail.com> <1343680215071-7564137.post@n2.nabble.com> <CAJo=hJsES44mXWjKmFqe7z+T_FHZ6Pi19toURyVp-wvW8AqQiw@mail.gmail.com> <1343684368384-7564144.post@n2.nabble.com> <CAM9Z-nnfwuR9UKtoQ1uACOMH3vhZKFxDkjEn5_azpGxd2GGjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:40:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHsS7-0008I7-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 12:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbaHNKkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 06:40:09 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:53424
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbaHNKkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 06:40:08 -0400
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Aug 2014 06:40:08 EDT
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <lpicquet@gmail.com>)
	id 1XHsBt-0007a4-CO
	for git@vger.kernel.org; Thu, 14 Aug 2014 03:23:29 -0700
In-Reply-To: <CAM9Z-nnfwuR9UKtoQ1uACOMH3vhZKFxDkjEn5_azpGxd2GGjJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255260>

You need to allow the directory to be read?
	<directory Path/to/your/repositories>
  		Allow from all
	</directory>




--
View this message in context: http://git.661346.n2.nabble.com/PROPFIND-405-with-git-http-backend-and-Smart-HTTP-tp7564017p7616843.html
Sent from the git mailing list archive at Nabble.com.
