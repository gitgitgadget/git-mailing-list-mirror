From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 02:30:13 -0400
Message-ID: <81bfc67a0903182330q786ef01ai9148e41664a3471a@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkBnX-0001N0-8S
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 07:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786AbZCSGaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 02:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbZCSGaS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 02:30:18 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:55913 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbZCSGaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 02:30:16 -0400
Received: by qyk16 with SMTP id 16so520943qyk.33
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uq0QDgQVbW1xN/+f3qGJmLTwiQwVVyxJKMC1JWhcMyM=;
        b=BZxMu+wX2Ckrg9kkVz8tWooBXUBjEMXhCerRdSiG5dGqufdlw4KJVtkMYZgvvPYYdB
         qahwE8BhFEJlmVOQYtIhgnsJDMmSvxk40qz4BnqqQQeQ+RCGB8zVe9Wp7ByqdTfyWx1K
         fP0ItpYQHRTZMZZVRQYlSSJrk78X0XqxqQGRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oWwTFLS3MUxNNHfOxNhpmqTd5Qth8ZzWmQypZSe8AdTizrqUO/QniWN6GEGqwySqWZ
         zM1SxxTa44U69NdHvChiDMGFgOBzJFaEj48cpf+CXKEs9z6ilOTFciTvH7SRfJYJjiHn
         DPvlkWnOlyi8y+/IAmooM7GNDgvA00+YdrKt4=
Received: by 10.229.81.140 with SMTP id x12mr1291943qck.35.1237444214064; Wed, 
	18 Mar 2009 23:30:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113721>

On Wed, Mar 18, 2009 at 7:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> In my humble opinion, we should focus on the data types we want to be
> able to support at the end of the summer first.

my 2 cents don't support xml, support sgml start at the least common
denominator and refine from there.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
