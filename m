From: Gordon Freeman <freemanmtc@gmail.com>
Subject: Workflow on git with 2 branch with specifc code
Date: Fri, 17 Jan 2014 10:14:28 -0200
Message-ID: <1389960868.21737.2.camel@pc14.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 13:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W48Z4-0004LJ-Av
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 13:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbaAQMaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 07:30:18 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:45634 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaAQMaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 07:30:14 -0500
Received: by mail-qe0-f49.google.com with SMTP id w4so3738064qeb.22
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 04:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:content-type:mime-version
         :content-transfer-encoding;
        bh=XCAajwoU2MZYcqOr5Vp6gslBbTFSZopImfAu4t8N0vA=;
        b=e7VKb27DOBkISDJtpUD2zk3x3/cMOcVGCPriEQVGdubmmoq+gG9ah9Nn6xEmlol7KB
         MJBPpEhXvMSHLN9UWhyE3qGYnrvRjIKDlktBaaZwfmffiE0Kt2j+5heAGVuoKvlwABOn
         QO3Aj9x2Up+Bap3DYRFo+F/MwdEoK58z2r9gJMH6I9FJ1PxDFN3OvVz6bwfyGzv9V2pT
         C53NrbosLnN3Z5Q6xrAtIgNL9R42RA6jMO/ObHcD0Hdg2n0AHK0wMwXt7iCGnoU/Uxtn
         ZIwrLaSOYDT0dshVzvi2Q7kjY8OQfl6vv6urgIlTWvTvlhe5hRQnmtypLQb4twDPtA6x
         rCgQ==
X-Received: by 10.140.93.111 with SMTP id c102mr2375876qge.53.1389961813265;
        Fri, 17 Jan 2014 04:30:13 -0800 (PST)
Received: from [192.168.1.111] (201.22.212.107.static.gvt.net.br. [201.22.212.107])
        by mx.google.com with ESMTPSA id ki4sm16111569qeb.0.2014.01.17.04.30.12
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 04:30:12 -0800 (PST)
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240596>

Hello guys, im Gordon.

I have a question about workflow with git that i dont know if im doing
it right.
I have 1 repo with 2 branchs the first is the master of the project.
the second is a branch copy of the master but he need to have some
specifc code because is code for a client.
so, every time that i updade master i need to merge master with client
branch and it give me conflicts of course that will hapen.
Well if was just me who work on this 2 branchs it will be easy to fix
the conflicts and let all work and shine.
But whe have here, 10 people woking on master branch and some times code
are lost on merge and we need to look on commits to search whats goin
on. 
What i just asking here is if its correct the workflow that i do. If for
some problem like this, the community have a standard resolution. Or if
what im doing here is all wrong.

Any help here will be apreciated.
Thx for all.

~                                                                                                                                               
~                                                                                                                                               
~                                                                                                                                               
~                                                                                          
