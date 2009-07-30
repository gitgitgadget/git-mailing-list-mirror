From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Thu, 30 Jul 2009 14:42:25 -0300
Message-ID: <b8bf37780907301042p4ed4c3e9x85e76ab04ca12696@mail.gmail.com>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org>
	 <1246289542-1596-1-git-send-email-cascardo@holoscopio.com>
	 <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
	 <20090629162738.GE4327@vespa.holoscopio.com>
	 <7vtz1yc2i3.fsf@alter.siamese.dyndns.org>
	 <b8bf37780907292026q61805aadhd2019eae77739c47@mail.gmail.com>
	 <20090730154446.GD1727@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 19:43:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWZeG-0000kK-Pa
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 19:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZG3Rm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbZG3Rm0
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 13:42:26 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:39156 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZG3RmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 13:42:25 -0400
Received: by qyk34 with SMTP id 34so975991qyk.33
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=txQcLGpSLqqOpAXyv6Hs4caCjCxmzb+h81fHV6IUSG4=;
        b=eDjmKpNk64VCCuErM8r8gQRq/Qx1xsxk61/ztlErxGIULlFjrRRme8tVp0AuEK66zK
         rr38nNs6+EWT86N2K8mefeQ3Lmbs3tMoy8g66vSRtDP5AAVVto3ALxobFDneEESC5SCj
         ax8qHdWpIF66uTV0Qif0buKpe83emT96Jy8bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WPmmqb/9Gnec0BAMN7ujqMahL/kiX5ryfmA5fJTxgQySw3jMcUWDxU2Dd6k4mdXctn
         kRnJxg2KCKYcKYvVUgg95JcurDXHxJw9H11Z0Jbx6RC7OslPj7A5Z9uQ6UDfw9BbAG4q
         nBCguT2p+BShT2cudAWciXKLhY4GqVVTQYEu4=
Received: by 10.220.95.212 with SMTP id e20mr1833534vcn.4.1248975745781; Thu, 
	30 Jul 2009 10:42:25 -0700 (PDT)
In-Reply-To: <20090730154446.GD1727@vespa.holoscopio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124473>

On 7/30/09, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> wro=
te:
> On Thu, Jul 30, 2009 at 12:26:14AM -0300, Andr=E9 Goddard Rosa wrote:
>> git gui uses 'po' at http://repo.or.cz/w/git-gui/git-gui-i18n.git to
>> handle all translations, including Brazilian Portuguese.
>>
>
> But do they use it for Documentation? It doesn't seem so. po4a seems =
to
> be a reasonable choice, which, in the end, means po too. But it would=
 be
> interesting to gather others experiences in keeping Documentation
> translations updated, not only software strings.

Sure, that's what po4a is meant for.

>> @Thadeu: would you please double check it and perhaps add your Acked=
-by?
>>
>
> It seems OK, but for three fixes as I've sent before. Would you mind
> re-sending them?

I've sent it including the contributions/fixes from you and Carlos.

Thanks,
Andre
