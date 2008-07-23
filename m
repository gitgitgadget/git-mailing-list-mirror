From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 01:49:26 +0200
Message-ID: <200807240149.27371.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <169F15EC-1A58-4C2A-84FC-3D14F7B4F1C5@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Miguel Arroz <arroz@guiamac.com>
To: =?utf-8?q?Jean-Fran=C3=A7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLo6T-0002C1-8t
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbYGWXtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 19:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbYGWXtj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:49:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:44306 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbYGWXti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:49:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so995949nfc.21
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ba0d3oNmPc0TKrUp4grJP6YcyWwnM8MTxJqGfEkHLGY=;
        b=LahWhHJfc2FxrUf/8HJWZJDSXzkxwx+AO3PKzCIc12AQgK9hGHF2UF8NONmh0hl5JB
         J9kreLhLfbPBdXVnf17NNAmrbIMLCz0GZZZRXyjgbyN8uDHYe7pZyPmR6RKqX8I8Czum
         +PVhECGbDRkeADupE7oCOItlRcLfIWWYceiRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FNxHLI6t4KY8I+bCmWjM4fIlT2y/3s52CrgCKSbpNad9jCTbY+grQU+pc/fZJQQgk+
         0Z6J/ZHAhY2oiYH+RqgkwfwDB9PtJ4iKSjzfxQIBpkuTA8E95xVxAWn28VI5wDJhQAdk
         Lyg33lAIAwCTp9DjPHjEstF5LddVUuRpAbKi4=
Received: by 10.210.71.13 with SMTP id t13mr441253eba.130.1216856975292;
        Wed, 23 Jul 2008 16:49:35 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id f4sm21489427nfh.27.2008.07.23.16.49.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 16:49:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <169F15EC-1A58-4C2A-84FC-3D14F7B4F1C5@yahoo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89810>

Dnia =C5=9Broda 23. lipca 2008 17:14, Jean-Fran=C3=A7ois Veillette napi=
sa=C5=82:
> Le 08-07-22 =C3=A0 21:25, Jakub Narebski a =C3=A9crit :
>
> > First there is a question about the form of survey. Should we use w=
eb
> > based survey, as the survey before (http://www.survey.net.nz), send=
ing
> > emails with link to this survey, or perhaps do email based survey,
> > with email Reply-To: address put for this survey alone?  Should we =
use
> > the same web survey service as before (found by Paolo Ciarrocchi fo=
r
> > first, 2006 survey, and used also for 2007 survey), or is there one
> > better (it would better be free, and without limitations on the num=
ber
> > of responses; in 2006 there were around 117 responses, in 2007 ther=
e
> > were 683 individual responses).
>=20
> Consider
> http://www.survs.com
> It is still in beta but already years ahead of the proposed solution.
> I don't know about the specific of the beta (cost, availability, =20
> etc.) but I had a live presentation of the product and it is an =20
> amazingly great product !

It certainly _looks_ nice, but it lacks one very important feature
(or at least I was not able to find it): the ability to download *RAW*
data to analyse it off-line using more advanced tools (like for
example Perl script to clean-up responses; spreadsheet like Excel or
Gnumeric, or some statictics tool like R to analyze data, for example
do a correlation between responses to different questions).

http://www.survey.net.nz allows to download raw data in modified
CSV format (modified as it allows for line continuation).  See for
example raw data for Git User's Survey 2007 results:
  http://git.or.cz/gitwiki/GitSurvey2007?action=3DAttachFile&do=3Dget&t=
arget=3Dsurveydata.csv

There is another nice thing that http://www.survey.net.nz is supposed
to have (but it doesn't unfortunately work; at least downloading
current layout of survey to tweak off-line doesn't/didn't work),
namely ability to create survey off-line using some specified text
format, and upload it, instead of creating it on-line (which might be
much work for large surveys).
=20
--=20
Jakub Narebski
Poland
