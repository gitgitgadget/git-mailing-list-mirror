From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 17:42:21 +0200
Message-ID: <e7bda7770708270842s57eea8a3jcc52e2e7e8464b75@mail.gmail.com>
References: <200708190128.43515.jnareb@gmail.com>
	 <200708270251.05762.jnareb@gmail.com>
	 <20070827014034.GD18160@spearce.org>
	 <200708271315.07919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgjU-00054v-Bk
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbXH0PmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755941AbXH0PmX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:42:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:22654 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbXH0PmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:42:22 -0400
Received: by wa-out-1112.google.com with SMTP id j4so2096476wah
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 08:42:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WWLoIqoBDqkUqjfd4qsEsMHre4BZxVmtnkdWwqqaKbJj/7zyMW3TIKVMCNPYKMfEGBi1unNjFn4PQaCaIAQfJC/eHWwWIp8ig9vGcp8fOQuZGIXXk9AcHclpk2GodeBUUqfCzfqQbLd82PThHyUnaKmXEh8ja68pc6WQ47WNZA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cb8vEXfjvxTa3XsHW77fnN/iMkUz9fwqLJsm9IPJ8KsiJVed/3XSPenBTNvL3SzLnlc1Rcn+IPHqKBKLUmNUgRg/tSk/wU1/V3RdgL0KHq+2aFmgO2F9M6oHDh5HQLevNV0POYMi45wAp+Hutza8pV8vSp0e+udhFsO75VHaq/s=
Received: by 10.114.154.1 with SMTP id b1mr1623823wae.1188229341886;
        Mon, 27 Aug 2007 08:42:21 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Mon, 27 Aug 2007 08:42:21 -0700 (PDT)
In-Reply-To: <200708271315.07919.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56852>

On 8/27/07, Jakub Narebski <jnareb@gmail.com> wrote:

> I wonder if PyGTK is as portable as Tcl/Tk...

Tk is integrated in the official Python library while PyGTK is not so
I guess Tk wins even on Python (Idle [included editor] and matplotlib
uses it as default).

PyGTK works pretty well though even on win32 (after installing a
handful dependencies). I haven't tried to compile any of these myself
though, compiling these things on win32 is usually a PITA.

//Torgil
