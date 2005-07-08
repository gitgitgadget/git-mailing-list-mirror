From: Mateusz Berezecki <mateuszb@gmail.com>
Subject: git and commiting
Date: Fri, 08 Jul 2005 16:07:34 +0200
Message-ID: <42CE88A6.5080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 16:06:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqtUR-00045c-C5
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 16:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVGHOFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 10:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbVGHODS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 10:03:18 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:10440 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261295AbVGHOC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 10:02:29 -0400
Received: by wproxy.gmail.com with SMTP id 36so611125wri
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 07:02:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qt/iNKa2mAsz51jTWz4QpuEk+q+RF3UP7M6G8GMF+u/oz5ty3sSmnv0Ua/z6cQfmPEJMVs8VAvAlKgW0HRqPBf9Gs1iIax6wk4VKGYlMpml8HLVaeXifxW22V8vWlVyTA9CdmzrW/sUSh30OO29qo3EaH6APF2ELnC5M+HoNLz4=
Received: by 10.54.59.7 with SMTP id h7mr3196074wra;
        Fri, 08 Jul 2005 07:02:28 -0700 (PDT)
Received: from ?192.168.0.150? ([82.139.13.231])
        by mx.gmail.com with ESMTP id 39sm10231019wrl.2005.07.08.07.02.25;
        Fri, 08 Jul 2005 07:02:28 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050704)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi list readers,

How to commit and check-in changes done to the checked-out source code?
The "git commit" command seems to only commit the changes locally
without pushing them via rsync.
Is there any way I can push commits via rsync? Am I missing the point
and git commit is not enough?

please CC me with the answer as I am not subscribed to the list.


regards
/mb
