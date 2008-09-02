From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [PATCH] Document sendemail.envelopesender configuration
Date: Mon, 1 Sep 2008 19:51:44 -0700
Message-ID: <03CD327C-0146-4B62-ADA3-D327C35A056D@develooper.com>
References: <1A4402DD-03B5-4951-B8CA-DB8A8E93D8C4@develooper.com> <1220214763-25790-1-git-send-email-ask@develooper.com> <g9f0qk$sp2$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 05:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaM7f-0003Jh-IE
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 05:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYIBCvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 22:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYIBCvx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 22:51:53 -0400
Received: from x8.develooper.com ([216.52.237.208]:52042 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYIBCvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 22:51:52 -0400
Received: (qmail 18810 invoked from network); 2 Sep 2008 02:51:50 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 2 Sep 2008 02:51:50 -0000
In-Reply-To: <g9f0qk$sp2$1@ger.gmane.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94643>


On Aug 31, 2008, at 14:01, Jakub Narebski wrote:

>> +       Default is the value of the 'sendemail.envelopesender'  
>> configuration
>> +       value; if that is unspecified, choosing the envelope sender  
>> is left
>
> s/configuration value/configuration variable/

Hi Jakub,

I thought so too, but used value for internal consistency with (most  
of) the rest of that documentation file.


- ask

-- 
http://develooper.com/ - http://askask.com/
