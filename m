From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 09 Feb 2006 02:06:22 +0100
Message-ID: <43EA958E.1090902@iaglans.de>
References: <43EA73C3.2040309@iaglans.de>	<7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>	<43EA7D57.7040409@iaglans.de>	<7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>	<43EA8DDA.3070906@iaglans.de> <7vzml1mmmh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 01:07:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zLP-0002sM-QW
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWBIAH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWBIAH3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:07:29 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:5638 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422708AbWBIAH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:07:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 3E5E13E9D
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 01:07:27 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00825-05 for <git@vger.kernel.org>;
	Thu, 9 Feb 2006 01:07:27 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 999EC3E51
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 01:07:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
In-Reply-To: <7vzml1mmmh.fsf@assigned-by-dhcp.cox.net>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15771>

Junio C Hamano wrote:
> Nicolas Vilz 'niv' <niv@iaglans.de> writes:
> 
> 
>>So, how do i tell git to send my identity-file to sshd? And could I
>>set an alias like in .git/remotes for that location / identity?
> 
> 
> That is not a git question but you are using me as an ssh
> helpdesk.  See ssh_config(5).
i didn't recognize that it had nothing to do with git.

Thank you very much for your help and your time. :)

Nicolas
