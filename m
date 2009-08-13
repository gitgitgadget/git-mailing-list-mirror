From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add 'stg prev' and 'stg next'
Date: Thu, 13 Aug 2009 23:30:46 +0100
Message-ID: <b0943d9e0908131530x61434a27n89b5f31ed046765a@mail.gmail.com>
References: <20090807104503.15805.95504.stgit@jazzy.zrh.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hannes Eder <heder@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbipg-00023b-NR
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZHMWar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 18:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbZHMWar
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:30:47 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:46459 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbZHMWaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 18:30:46 -0400
Received: by bwz22 with SMTP id 22so862850bwz.18
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j2Is2Q5mPBD0892/mbLhml7rFf5zmUhjMfMIMcKIMxU=;
        b=ch5k10Im207ILUDGwW5dY66vDaSaTdT4DU4tPNIRwu2lC7m9cfwr+VKd6uD1bP9kX9
         WA3FB/GzOZIqaSm9XV6bt94EEm4tkOjbpcPKfVsDOLvtG5ORBE01rv80wbLhe5Qs5wOt
         5A7D1114VwL+e/Id3EFLn8NnDP8XLXIsV8LcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k8T6BJjEcXKdldhvGrZpAA5KVRFFTg1GIxy9Yq/6l/TjF9sWCqg7TBP1Xt9h9wmMeb
         /olYYLZPpANqL8R0cMR3GuLx0u4cHNC2FuroGAJ390mfWJzzQp/NL280BLCHS6x+JyHH
         ks0y3prWSlWmbNTkzs2S0JwKYwqHdYO62HcfQ=
Received: by 10.223.113.9 with SMTP id y9mr451059fap.19.1250202646631; Thu, 13 
	Aug 2009 15:30:46 -0700 (PDT)
In-Reply-To: <20090807104503.15805.95504.stgit@jazzy.zrh.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125889>

2009/8/7 Hannes Eder <heder@google.com>:
> These commands are related to 'stg top'. =A0They print the patch belo=
w
> resp. above the topmost patch, given that they exist.

I applied it. Thanks.

--=20
Catalin
