From: "Franz Liedke" <franz@develophp.org>
Subject: Re: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 16:18:39 +0100
Organization: develoPHP
Message-ID: <op.vsb95dilbl4hj1@metalltrottel.fritz.box>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
 <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz9WL-0006wi-W8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab1CNPRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:17:10 -0400
Received: from relay01.alfahosting-server.de ([80.86.191.88]:37535 "EHLO
	relay01.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756861Ab1CNPRI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 11:17:08 -0400
Received: by relay01.alfahosting-server.de (Postfix, from userid 1001)
	id 737CD32C0008; Mon, 14 Mar 2011 16:17:06 +0100 (CET)
X-Spam-DCC: : relay01 1356; Body=1 Fuz1=1 Fuz2=1
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=BAYES_50 autolearn=disabled
	version=3.2.5
Received: from alfa3007.alfahosting-server.de (alfa3007.alfahosting-server.de [82.197.146.14])
	by relay01.alfahosting-server.de (Postfix) with ESMTP id 52CF832C0266;
	Mon, 14 Mar 2011 16:16:58 +0100 (CET)
Received: from metalltrottel.fritz.box (sd-89-66.stud.uni-potsdam.de [141.89.89.66])
	by alfa3007.alfahosting-server.de (Postfix) with ESMTPSA id 2E82E2F04CB4;
	Mon, 14 Mar 2011 16:16:58 +0100 (CET)
In-Reply-To: <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com>
User-Agent: Opera Mail/11.01 (Win32)
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with ClamAV 0.97/12833/Mon Mar 14 09:09:46 2011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168990>

Hey,

thanks for your response.

"git status" and "git branch" both tell me I'm on my feature branch.

.git/packed-refs and .git/info/refs are both not updated.
.git/refs/heads/168-users-mass-edit is updated.

On Mon, 14 Mar 2011 16:09:39 +0100, Sverre Rabbelier  
<srabbelier@gmail.com> wrote:

> Heya,
>
> On Mon, Mar 14, 2011 at 14:18, Franz Liedke <franz@develophp.org> wrote:
>> I am currently having some trouble with a local Git branch.
>> It seems the branch pointer is not updated when I make new commits to  
>> that
>> particular branch.
>
> You might not be on any branch/the branch you expect. What does 'git
> status' and 'git branch ' say?
>


-- 
Using Opera's revolutionary email client: http://www.opera.com/mail/
