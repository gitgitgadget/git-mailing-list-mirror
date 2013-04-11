From: Joel Thompson <joel.thompson@macquarietextiles.com.au>
Subject: error: Trying to write ref refs/heads/master with nonexistant object
Date: Thu, 11 Apr 2013 06:02:46 +0000
Message-ID: <6EC627602B7D9F4691EED554E055463602C96B5A@Aquarion.MTGLAU.mtgl.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 08:26:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQAy4-0002DT-PE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 08:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab3DKG0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 02:26:41 -0400
Received: from mail.macquarietextiles.com.au ([203.36.230.69]:41437 "EHLO
	mail.macquarietextiles.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753785Ab3DKG0k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 02:26:40 -0400
Received: from exchange.mtgl.com.au (aquarion.mtglau.mtgl.com.au [203.4.205.200])
	by mail.macquarietextiles.com.au (Postfix) with ESMTP id AD11A17B73
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 16:02:47 +1000 (EST)
Received: from AQUARION.MTGLAU.mtgl.com.au ([fe80::8531:aac2:25f5:4cdd]) by
 Aquarion.MTGLAU.mtgl.com.au ([fe80::8531:aac2:25f5:4cdd%10]) with mapi id
 14.02.0328.009; Thu, 11 Apr 2013 16:02:47 +1000
Thread-Topic: error: Trying to write ref refs/heads/master with nonexistant
 object
Thread-Index: Ac42eiNmo6YYEhlrRUqdnNZslSP3fg==
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [203.4.205.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220826>

Hi,

I can no longer clone my git repository from v1.7 client, i get error: Trying to write ref refs/heads/master with nonexistant object.

It is a remote repo that im using ssh to connect to, and i have done everything i can find on google from creating a new master branch, cleaning up the repo, removing dangling bits etc. etc.

So far I have come to the conclusion that while creating a tag on my v1.8 client in windows, something has happened which has stopped the repo from being compatible with v1.7 (as i am still able to clone it with 1.8).

The full message when trying to clone is:

Initialized empty Git repository in /home/jthompso/Downloads/mtsd/.git/
remote: Counting objects: 2464, done.
remote: Compressing objects: 100% (905/905), done.
remote: Total 2464 (delta 1201), reused 2446 (delta 1186)
Receiving objects: 100% (2464/2464), 652.66 KiB, done.
Resolving deltas: 100% (1201/1201), done.
error: refs/remotes/origin/master does not point to a valid object!
error: Trying to write ref refs/heads/master with nonexistant object fdf19005911f07e3246649f906e0d45fa9ff884f
fatal: Cannot update the ref 'HEAD'.

Regards,

Joel Thompson
I.T. Support Officer

Macquarie Textile Solutions
211 East St, Albury NSW 2640
www.macquarietextiles.com.au
T: +61 2 6043 0302 F: +61 2 6041 1321
