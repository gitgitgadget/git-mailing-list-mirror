From: Pascal Obry <pascal@obry.net>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 19:08:27 +0200
Organization: Home - http://www.obry.net
Message-ID: <4899DA8B.3010105@obry.net>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net> <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net> <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luciano Rocha <luciano@eurotux.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:11:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQmXG-0006pZ-Op
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 19:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbYHFRIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 13:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbYHFRIq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 13:08:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:53510 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbYHFRIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 13:08:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so7206nfc.21
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 10:08:43 -0700 (PDT)
Received: by 10.103.244.10 with SMTP id w10mr1612878mur.67.1218042523561;
        Wed, 06 Aug 2008 10:08:43 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.201.122])
        by mx.google.com with ESMTPS id j9sm34047005mue.5.2008.08.06.10.08.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 10:08:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91529>

Junio C Hamano a =C3=A9crit :
> Perhaps something like this.  This must be another one of those
> regressions introduced in C rewrite.

Works fine now. Thanks.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
