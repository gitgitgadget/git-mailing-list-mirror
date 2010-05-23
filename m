From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking extra
Date: Sun, 23 May 2010 13:26:20 +0000
Message-ID: <AANLkTimhFx4ydPvTGCuOvomEPCVH8EoRTtHUeDVIK0mz@mail.gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
	 <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost>
	 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
	 <20100522222746.GA2694@localhost>
	 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
	 <20100523115127.GA20443@localhost>
	 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 15:26:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGBCE-00008k-RY
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 15:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab0EWN0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 09:26:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49008 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab0EWN0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 09:26:20 -0400
Received: by iwn6 with SMTP id 6so2810815iwn.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hdwPdN6JX1GRL5a5TJlDP1z0w5VqAkXmoS7z+eVDS4I=;
        b=Pg4p6nEjWk3mpjYLsz90KSVlplAfJiQcp2hgwjl8bL6Z8Bh6XauW38Y+rPHPEebrRZ
         DCWckMCIuboskTTxYGd93GGueJ9jBnb33X3+glbHROHoH0QUT4uFUAPKf8wGx5M4U0pz
         NlhWVyADHlYX4WZNOh082Z3brL8HjBLtYkL0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fqSEE4aATPeZQYxbbHkY/1bCoaIUKkL3OeRbD63JNYGpIkI0CvT9hNdbPwwWTpSmlG
         noWJneMyepURmU1YgGIZ+i1snSMOGWNoV46OkHnDZnP384voj6wJ+5c+yPK9OFbiXeS8
         shcMqhmUePwE5iYQ9sf2Gj/c5Yp0vvEB+tCfk=
Received: by 10.231.187.29 with SMTP id cu29mr3036080ibb.70.1274621180119; 
	Sun, 23 May 2010 06:26:20 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 23 May 2010 06:26:20 -0700 (PDT)
In-Reply-To: <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147577>

On Sun, May 23, 2010 at 12:53, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:

> I don't have strong feelings about the need for this feature, but it
> has been requested so it's probably useful.

It is, sanity checks for broken user tools like these are
unfortunately important for Windows adoption of Git.
