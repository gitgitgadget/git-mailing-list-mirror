From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 10:55:45 +0100
Message-ID: <e2b179460904220255v58986bd5q7c22eb3ab8486157@mail.gmail.com>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
	 <20090407181259.GB4413@atjola.homenet>
	 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
	 <20090407202725.GC4413@atjola.homenet>
	 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
	 <20090410T203405Z@curie.orbis-terrarum.net>
	 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
	 <20090414T202206Z@curie.orbis-terrarum.net>
	 <1240362948.22240.76.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Matt Enright <awickedshimmy@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 11:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwZCk-0007wV-O2
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 11:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZDVJzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 05:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZDVJzs
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 05:55:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:41108 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbZDVJzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 05:55:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1926193ywb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I15cAxKMYUqSPfRwPwsMM9E9fE6bNvYmXjYEBqEEuik=;
        b=IHt6OBv+VeFz55Y7pSjvhexxJvW+BlsD2mrSUoWgz72lZWVuqbPg+dKLLMgDeMCI7s
         6P6EporRqalMePzf25Mi624HH5Q8gpb0K5cknMcQnYLX3rE0EP4i7sG+mQKywb2RnhHD
         qx/tTNUVnTyMehawJA6nhXtrIgGr185Ml5Mi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dxXiWplxSlcwXGNZSTua5PQ+yTSHzOyDnslgjoo1Jhb43IQBxL7z0VwTDAtk/S0OEC
         LRDOK7ffPC2dAsLkoJCMYrtU2cLqTuA4MnLoTDoV3IY7H/iQRC/3FCtayp5SH6c65Tf8
         rFW5OF3py0Wn9GGot/qX3vv99zB19d1NM2fUM=
Received: by 10.151.6.2 with SMTP id j2mr10274789ybi.88.1240394145821; Wed, 22 
	Apr 2009 02:55:45 -0700 (PDT)
In-Reply-To: <1240362948.22240.76.camel@maia.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117185>

2009/4/22 Sam Vilain <sam@vilain.net>
> Now that the GSoC projects have been announced I can give you the good
> news that one of our two projects...

It's sort of three, really...

http://socghop.appspot.com/student_project/show/google/gsoc2009/mono/t124022708105

Mike
