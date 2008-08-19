From: Pascal Obry <pascal@obry.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 13:27:19 +0200
Organization: Home - http://www.obry.net
Message-ID: <48AAAE17.1070800@obry.net>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>	 <48AA7BE9.4040108@sneakemail.com>	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>	 <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>	 <vpqk5edid2y.fsf@bauges.imag.fr> <ee521d6f0808190309n7f0114a6q2e8113238cb2142b@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?TGlzdHMgUGV0ZXIgVmFsZGVtYXIgTcO4cmNo?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Alexander E Genaud <alex@genaud.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVPOC-0007u8-2w
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 13:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbYHSL1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYHSL1d
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 07:27:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:12663 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYHSL1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 07:27:33 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2476654wri.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 04:27:32 -0700 (PDT)
Received: by 10.90.119.20 with SMTP id r20mr393025agc.83.1219145249852;
        Tue, 19 Aug 2008 04:27:29 -0700 (PDT)
Received: from ?192.168.0.100? ( [90.2.74.169])
        by mx.google.com with ESMTPS id 7sm123354wrl.22.2008.08.19.04.27.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 04:27:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <ee521d6f0808190309n7f0114a6q2e8113238cb2142b@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92847>


For what it's worth, I have added this since I've been working with Git 
on my aliases:

[alias]
  staged = diff --cached

Since then I'm always running:

    $ git staged

This looks more intuitive to me and faster than typing:

    $ git diff --cached

I agree that "stage", "staging area" is a clean term to use.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
