From: <mysql.jorge@decimal.pt>
Subject: Re: Newbie to git
Date: Sun, 27 Dec 2009 23:00:04 +0000
Message-ID: <ecddd9ed719d3d854b2248970cdb9cdf@192.168.1.222>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>	<3a9710ae6b01fabf3b462da607af2534@192.168.1.222>	<26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>	<0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222> <m27hs8t5b7.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 00:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP25m-0001f7-D4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 00:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZL0W7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 17:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbZL0W7y
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 17:59:54 -0500
Received: from mailrly02.isp.novis.pt ([195.23.133.212]:57857 "EHLO
	mailrly02.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZL0W7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 17:59:53 -0500
Received: (qmail 29981 invoked from network); 27 Dec 2009 22:59:51 -0000
Received: from unknown (HELO mailfrt06.isp.novis.pt) ([195.23.133.198])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly02.isp.novis.pt with compressed SMTP; 27 Dec 2009 22:59:51 -0000
Received: (qmail 29310 invoked from network); 27 Dec 2009 22:59:51 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt06.isp.novis.pt with SMTP; 27 Dec 2009 22:59:51 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id B245D3D539
	for <git@vger.kernel.org>; Sun, 27 Dec 2009 23:00:04 +0000 (WET)
In-Reply-To: <m27hs8t5b7.fsf@whitebox.home>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135719>

Hi Andreas,

> You probably want to create a bare repository in this directory:
> 
> $ git init --bare foo.git
> 

Ok one more point, seams to be that!
Forgive my really newbie question:

not i have:
/home/apache/gitprojects/mydir.git

created with: git init --base mydir.git

Now, inside here, what should i do to create my projects:

mkdir myproject1
cd myproject1
git init
touch a.txt
git add .
git commit -m "1st commit"


am i correct or not really?
